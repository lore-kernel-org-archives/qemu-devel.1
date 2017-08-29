Received: from eggs.gnu.org ([2001:4830:134:3::10]:53458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmhPj-0000yg-6b
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmhPg-0003p5-2I
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:22:47 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:39856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dmhPf-0003of-M4
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:22:43 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1502109458-31251-5-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1502109458-31251-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1502109458-31251-5-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Tue, 29 Aug 2017 16:22:31 +0200
Message-ID: <w51mv6ifo7s.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH V8 4/6] hmp: create a throttle
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

On Mon 07 Aug 2017 02:37:36 PM CEST, Pradeep Jagadeesh wrote:
> This patch creates a throttle initialization function to maximize the
> code reusability. The same code is also used by fsdev.
>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
