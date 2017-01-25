Received: from eggs.gnu.org ([2001:4830:134:3::10]:56215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cWKS6-0005G4-EV
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:05:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cWKS3-0008FA-BO
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:05:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cWKS3-0008Em-39
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:05:15 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0PA3kKI070110
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 05:05:13 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 286safsjph-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 05:05:12 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 25 Jan 2017 03:05:12 -0700
References: <1477674916-6795-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<08201dc9-c077-feee-14e1-a8f0f225b9d7@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 25 Jan 2017 11:05:07 +0100
MIME-Version: 1.0
In-Reply-To: <08201dc9-c077-feee-14e1-a8f0f225b9d7@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <d41fe198-f65f-2ee3-53a7-4008c3f57c83@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] Qemu: gdbstub: fix vCont
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, palves@redhat.com

On 01/12/2017 05:45 PM, Claudio Imbrenda wrote:
> Hello,
> 
> just a respectful poke to remind about this patchset :)

Can you maybe resend/rebase the patch set? The target-s390x folder has moved.
