import 'package:flutter/material.dart';
import 'package:dimension_machine_task/widgets/common/custom_container.dart';

class JobCard extends StatelessWidget {
  final String? title;
  final String? desc;

  const JobCard({super.key, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCompanyLogo(),
            const SizedBox(width: 16),
            Expanded(child: _buildJobDetails()),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyLogo() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildJobDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildJobHeader(),
        const SizedBox(height: 4),
        _buildCompanyName(),
        const SizedBox(height: 12),
        _buildJobMetaInfo(),
        const SizedBox(height: 12),
        _buildJobDescription(),
      ],
    );
  }

  Widget _buildJobHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(
         title?? "US IT Technical Recruiter" .split(' ')
                            .take(4)
                            .join(' '),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            overflow: TextOverflow.ellipsis,

          ),
          
        ),
        Icon(
          Icons.bookmark_border,
          color: Colors.grey[600],
          size: 20,
        ),
      ],
    );
  }

  Widget _buildCompanyName() {
    return const Text(
      "Ora Apps Inc",
      style: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildJobMetaInfo() {
    return Row(
      children: [
        _buildMetaItem(Icons.location_on, "Remote or Hyattsville, MD, USA"),
        const SizedBox(width: 16),
        _buildMetaItem(Icons.schedule, "2 to 8 yrs"),
        const SizedBox(width: 16),
        _buildMetaItem(Icons.attach_money, "Not Disclosed"),
      ],
    );
  }

  Widget _buildMetaItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.grey[600], size: 16),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(color: Colors.grey[700], fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildJobDescription() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.description, color: Colors.grey[600], size: 16),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            desc??"Join our team of growing software professionals Ever found yourself working with an open source library that is just not working...",
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}