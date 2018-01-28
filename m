Received: from eggs.gnu.org ([2001:4830:134:3::10]:52085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1efnAJ-0000kl-5O
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 08:38:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1efnAG-0003TD-3z
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 08:38:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43846
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1efnAF-0003Sh-To
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 08:38:32 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0SDXt5K025380
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 08:38:30 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fs7dcbpy9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 08:38:29 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sun, 28 Jan 2018 08:38:29 -0500
References: <151697279368.755.604390001128478490@5adcb62bf0d6>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sun, 28 Jan 2018 08:38:24 -0500
MIME-Version: 1.0
In-Reply-To: <151697279368.755.604390001128478490@5adcb62bf0d6>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <4e2b09bd-c08f-ef6a-948f-a488051effcd@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] tpm: add CRB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Cc: famz@redhat.com, ehabkost@redhat.com, mst@redhat.com, armbru@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, marcel@redhat.com, rth@twiddle.net

On 01/26/2018 08:19 AM, no-reply@patchew.org wrote:
> Hi,
>
> This series failed build test on s390x host. Please find the details below.

We can ignore this and the other emails' errors since the patch's 
dependencies are in my tpm-next tree.
