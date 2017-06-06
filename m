Received: from eggs.gnu.org ([2001:4830:134:3::10]:59072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dIGfg-0002Si-Kw
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dIGfc-0008AH-LO
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:45:28 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:42798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dIGfc-00089v-Bo
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:45:24 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170605123908.18777-20-pbonzini@redhat.com>
References: <20170605123908.18777-1-pbonzini@redhat.com>
	<20170605123908.18777-20-pbonzini@redhat.com>
Date: Tue, 06 Jun 2017 17:45:22 +0200
Message-ID: <w51k24p3yst.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 19/19] block: make accounting thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

On Mon 05 Jun 2017 02:39:08 PM CEST, Paolo Bonzini wrote:
> I'm not trying too hard yet.  Later, with multiqueue support,
> this may cause mutex contention or cacheline bouncing.
>
> Cc: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
