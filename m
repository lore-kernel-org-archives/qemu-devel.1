Received: from eggs.gnu.org ([2001:4830:134:3::10]:55203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVwac-0000pR-QU
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVwaY-0008Q7-Rz
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:08:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43281
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVwaY-0008Pp-NA
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:08:42 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6E93jQ9029483
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 05:08:41 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bph7xuu32-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 05:08:41 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 05:08:41 -0400
References: <1499961789-127874-1-git-send-email-borntraeger@de.ibm.com>
	<20170714110325.67e7d205@gondolin>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 11:08:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170714110325.67e7d205@gondolin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <213f15fd-5410-d869-ce14-2cdc2a5880fd@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/7] s390: remaining patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>

On 07/14/2017 11:03 AM, Cornelia Huck wrote:
> On Thu, 13 Jul 2017 18:03:02 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> here is a bunch of patches that teaches recent HW features
>> to the CPU model and kvm code in QEMU. We also add the 
>> enhanced suppression on protection facility to the z12 and later
>> for the 2.10 machine type.
> 
> Looks good from my side.
> 
> I assume you'll put out a pull request soon?
> 

Yes. Will do one today unless there is more feedback.
