Received: from eggs.gnu.org ([2001:4830:134:3::10]:39907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ds8hx-0005qY-7y
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ds8hs-0004UY-28
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:32:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34144
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ds8hr-0004UA-RO
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:31:59 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8DET5l3136571
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 10:31:59 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cy5y3sw8v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 10:31:58 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 13 Sep 2017 15:31:56 +0100
References: <cover.1505225353.git.alifm@linux.vnet.ibm.com>
	<a30f50d543182914e83cba5501f615a8ded2b858.1505225353.git.alifm@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 13 Sep 2017 16:31:53 +0200
MIME-Version: 1.0
In-Reply-To: <a30f50d543182914e83cba5501f615a8ded2b858.1505225353.git.alifm@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <73299e84-a502-2367-17c3-a72c5e34167f@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] virtio-gpu-ccw: Create a virtio gpu
 device for the ccw bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, thuth@redhat.com, cohuck@redhat.com, kraxel@redhat.com



On 09/12/2017 04:26 PM, Farhan Ali wrote:
> Wire up the virtio-gpu device for the CCW bus. The virtio-gpu
> is a virtio-1 device, so disable revision 0.
> 
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>

[..]
