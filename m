Received: from eggs.gnu.org ([2001:4830:134:3::10]:35125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongdwdw@linux.vnet.ibm.com>) id 1dDMUY-0004Qr-CD
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongdwdw@linux.vnet.ibm.com>) id 1dDMUR-0000Oz-Ts
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:57:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47287
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongdwdw@linux.vnet.ibm.com>)
	id 1dDMUR-0000Od-Nl
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:57:35 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4O2rhV1027786
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 22:57:34 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2amynvm29h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 22:57:34 -0400
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <dongdwdw@linux.vnet.ibm.com>;
	Wed, 24 May 2017 12:57:31 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v4O2vMRS66846808
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 12:57:30 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v4O2uvKx023585
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 12:56:57 +1000
Received: from oc8580814772.ibm.com ([9.115.112.58])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	v4O2uugm023320
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 12:56:56 +1000
From: Wang Dong <dongdwdw@linux.vnet.ibm.com>
Date: Wed, 24 May 2017 10:56:41 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <f0b11c2d-9f61-c4c2-4b55-58644b760e31@linux.vnet.ibm.com>
Subject: [Qemu-devel] new to qemu with a simple question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


Hi guys,

I am new to qemu. But I need do some job in it right now.

When I try read qmp code. I found a interesting part against it.

Some C source code is generate from json file.

I wonder why this? What is the benefits of this?

Thanks in advance.


-- 
Best regards. Wang Dong
