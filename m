Received: from eggs.gnu.org ([2001:4830:134:3::10]:59328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cVuuB-0000Ge-Rg
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 01:48:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cVuu8-0006pJ-QE
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 01:48:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47101
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cVuu8-0006p7-LB
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 01:48:32 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0O6hequ030585
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 01:48:30 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0b-001b2d01.pphosted.com with ESMTP id 285u7um7f7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 01:48:30 -0500
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 24 Jan 2017 16:48:27 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <1484299420-23031-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1484299420-23031-1-git-send-email-nikunj@linux.vnet.ibm.com>
Date: Tue, 24 Jan 2017 12:17:22 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87fuk954zp.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] POWER9 TCG enablements - part12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> writes:

> This series contains 5 new instructions for POWER9 ISA3.0
>     VSX Scalar Test Data Class
>     VSX Vector Test Data Class
>
> Changelog:
> v1:
> * Zero the match variable in the element loops
>
> v0:
> * Concise logic for identifying data class in Scalar/Vector 
>   test data class instructions
>
> Nikunj A Dadhania (2):
>   target-ppc: Add xvtstdc[sp,dp] instructions
>   target-ppc: Add xststdc[sp, dp, qp] instructions

Ping?

Regards
Nikunj
