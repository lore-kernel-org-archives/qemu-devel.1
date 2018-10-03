Received: from eggs.gnu.org ([2001:4830:134:3::10]:39626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7iG0-0003q5-5H
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7iFx-0000AC-Fh
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:36:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g7iFx-00009s-6x
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:36:05 -0400
References: <20180921082217.29481-1-rkagan@virtuozzo.com>
	<54f9804b-405d-e587-73c5-0fc9b9aa07b7@redhat.com>
	<20181003142503.GC24354@rkaganb.sw.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9a4e1a90-8785-a724-1b85-32afea800c7d@redhat.com>
Date: Wed, 3 Oct 2018 16:35:48 +0200
MIME-Version: 1.0
In-Reply-To: <20181003142503.GC24354@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/10] hyperv: add connection infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, Liran Alon <liran.alon@oracle.com>, Igor Mammedov <imammedo@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>

On 03/10/2018 16:25, Roman Kagan wrote:
>> I queued all three series, though if I were to post a pull request now
>> I'd stop before "hyperv: add synic message delivery".
> To make sure I interpret this correctly: do the remaining patches need
> more work beside the things you've commented on?
> 
> Also do you want me to post the corrected stuff as incremental fixups or
> as a full-fledged respin?  In the latter case should I assume your r-b
> on all patches before that one?

No need to do anything, I just wanted an explanation of patch 5 (I can
fix the "Mesage" thing myself).

Paolo
