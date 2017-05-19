Received: from eggs.gnu.org ([2001:4830:134:3::10]:53107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dBjWH-0001dM-RX
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:08:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dBjWC-0002lC-UO
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:08:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52151
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dBjWC-0002jn-OR
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:08:40 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4JExcrT145917
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 11:08:39 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ahwj3g5dy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 11:08:39 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 19 May 2017 16:08:36 +0100
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
	<20170505173507.74077-4-pasic@linux.vnet.ibm.com>
	<20170508164505.GG2120@work-vm>
	<3e0195e2-ada5-2efc-1feb-e2415761e7bc@linux.vnet.ibm.com>
	<20170515180129.GC2324@work-vm>
	<2bf9d9d3-86ed-da36-dc81-415065e08a91@linux.vnet.ibm.com>
	<20170519145502.GQ2081@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 19 May 2017 17:08:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170519145502.GQ2081@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <924686ea-48b1-bc5e-8311-6d678d8a05cf@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 03/10] s390x/css: add vmstate entities for
 css
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>



On 05/19/2017 04:55 PM, Dr. David Alan Gilbert wrote:
> Dave
> P.S. I'm out for about a week.

Thanks for the info! Could you say something about our 'two
devices two sections vs two devices one section' dilemma
form PATCH 06/10 before leaving? I do not want to be pushy,
but I'm also eager to make progress :).

Have a good whatever it is next week!

Halil 
