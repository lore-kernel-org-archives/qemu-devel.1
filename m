Received: from eggs.gnu.org ([209.51.188.92]:43848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGjVl-0002S3-PI
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGjVk-0006y7-TL
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:17:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hGjVk-0006x8-BX
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:17:56 -0400
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
	<20190305172905.GD13806@stefanha-x1.localdomain>
	<2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
	<20190401090724.GA643@stefanha-x1.localdomain>
	<C0F977FC-A960-4FA5-B2DF-BBD9DA664F8A@oracle.com>
	<0c0f2d54-2b94-e278-cbce-b7175ba29cc8@redhat.com>
	<85DF2701-24E2-4159-94F5-CB9C60D333BE@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5d5049df-655a-8ff1-d8fb-d363d684459b@redhat.com>
Date: Wed, 17 Apr 2019 14:17:46 +0200
MIME-Version: 1.0
In-Reply-To: <85DF2701-24E2-4159-94F5-CB9C60D333BE@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Following up questions related to QEMU and I/O
 Thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Li <wei.d.li@oracle.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Sergio Lopez Pascual <slp@redhat.com>

On 17/04/19 03:38, Wei Li wrote:
> Thanks Paolo for your response and clarification.
> 
> Btw, is there any rough schedule about when are you planning to start
> working on the multi queue feature?  Once you start working on the
> feature, I would like to hear more details about the design and
> better understand how this feature will benefit the performance of
> virtio-scsi.

I wish I knew... :)  However, hopefully I will share the details soon
with Sergio and start flushing that queue in 4.1.

Paolo
