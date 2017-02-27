Received: from eggs.gnu.org ([2001:4830:134:3::10]:38829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ciDy3-0005vb-23
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ciDxz-00034q-Nm
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:35:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1ciDxz-00033l-Eu
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:35:23 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1R5SWjI029847
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 00:35:22 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28u6at75gw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 00:35:21 -0500
Received: from localhost
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 27 Feb 2017 11:05:19 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 03F683940033
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 11:05:17 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
	by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v1R5YBif13172852
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 11:04:11 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
	by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v1R5ZG0u017144
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 11:05:16 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <CAFEAcA_TaQf7H=qc6wCHrT88XFTo21i7L9=PHTNFpySA0YCOSw@mail.gmail.com>
References: <1486976352-549-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<CAFEAcA_TaQf7H=qc6wCHrT88XFTo21i7L9=PHTNFpySA0YCOSw@mail.gmail.com>
Date: Mon, 27 Feb 2017 11:05:14 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <878tosp565.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH 1/2] risu_ppc64le: fix the typo nb => rb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 13 February 2017 at 08:59, Nikunj A Dadhania
> <nikunj@linux.vnet.ibm.com> wrote:
>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> ---
>>  ppc64.risu | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Thanks, applied to risu master.

Thanks.


> PS: I nearly missed this patchset entirely, because it doesn't have
> a cover letter. If you could provide cover letters for multi-patch
> series in future that would be really helpful.

Sure, will keep that in mind.

Regards
Nikunj
