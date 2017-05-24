Received: from eggs.gnu.org ([2001:4830:134:3::10]:40833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongdwdw@linux.vnet.ibm.com>) id 1dDRpB-0000qm-Cz
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongdwdw@linux.vnet.ibm.com>) id 1dDRp6-0008FY-Dn
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:39:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongdwdw@linux.vnet.ibm.com>)
	id 1dDRp6-0008FQ-2k
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:39:16 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4O8dBBi031243
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 04:39:14 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2amvavpd64-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 04:39:13 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <dongdwdw@linux.vnet.ibm.com>;
	Wed, 24 May 2017 18:38:51 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v4O8celc39125074
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 18:38:48 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v4O8c83P018658
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 18:38:09 +1000
References: <f0b11c2d-9f61-c4c2-4b55-58644b760e31@linux.vnet.ibm.com>
	<20170524031141.GI12279@lemon.lan>
From: Wang Dong <dongdwdw@linux.vnet.ibm.com>
Date: Wed, 24 May 2017 16:37:58 +0800
MIME-Version: 1.0
In-Reply-To: <20170524031141.GI12279@lemon.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <d68094a6-574e-9bb7-5574-298285ac477c@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] new to qemu with a simple question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

Thank you, Fam.


On 05/24/2017 11:11 AM, Fam Zheng wrote:
> On Wed, 05/24 10:56, Wang Dong wrote:
>> Some C source code is generate from json file.
>>
>> I wonder why this? What is the benefits of this?
> This allows you to concentrate on the high level semantics of the QMP API,
> without worrying about C syntax and structural code here and there. In one
> word, more conciseness and little code duplication.
>
> If done in C, it would be much more lines of code and hardly readable.
>
> Fam
>

-- 
Best regards. Wang Dong
