Received: from eggs.gnu.org ([2001:4830:134:3::10]:34584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cqhIs-0005u1-N7
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cqhIo-0004Qr-PE
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:31:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cqhIo-0004QJ-FB
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:31:54 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2MET6aD012382
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 10:31:53 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29b9vngkpu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 10:31:52 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 22 Mar 2017 08:31:51 -0600
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 22 Mar 2017 15:31:46 +0100
MIME-Version: 1.0
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <d5d5cef5-7615-c5db-1026-f16ca1ecdbd6@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 00/81] Patch Round-up for stable 2.8.1,
 freeze on 2017-03-27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

On 03/21/2017 12:07 AM, Michael Roth wrote:
> Hi everyone,
> 
> The following new patches are queued for QEMU stable v2.8.1:
> 
>   https://github.com/mdroth/qemu/commits/stable-2.8-staging
> 
> The release is planned for 2017-03-30:
> 
>   http://wiki.qemu.org/Planning/2.8
> 
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.
> 
> Testing/feedback is greatly appreciated.
> 
> Thanks!

as a heads up, today I queued "[PATCH v2] target/s390x: Fix broken
user mode" for the s390 tree. We (Cornelia and myself) will try to
get this patch out soon so that it hits mainline before the freeze.

Christian
