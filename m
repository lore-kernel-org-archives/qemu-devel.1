Received: from eggs.gnu.org ([2001:4830:134:3::10]:55418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dpD4w-0001iY-Nk
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dpD4F-0003HE-SN
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:35:42 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:36428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dpD4F-0003G4-Fk
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:34:59 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1504541267-36954-5-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1504541267-36954-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1504541267-36954-5-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Tue, 05 Sep 2017 14:03:03 +0200
Message-ID: <w51lglt73pk.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 4/6] hmp: create a throttle
 initialization function for code reusability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On Mon 04 Sep 2017 06:07:45 PM CEST, Pradeep Jagadeesh wrote:
> This patch creates a throttle initialization function to maximize the
> code reusability. The same code is also used by fsdev.
>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>

I had already reviewed this patch when you sent v8 -the first v8 :)-

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
