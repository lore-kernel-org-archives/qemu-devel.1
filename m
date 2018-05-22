Received: from eggs.gnu.org ([2001:4830:134:3::10]:43054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fKyHV-0002RW-QX
	for qemu-devel@nongnu.org; Mon, 21 May 2018 23:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fKyHS-0008DX-Ok
	for qemu-devel@nongnu.org; Mon, 21 May 2018 23:48:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51672 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fKyHS-0008DI-KT
	for qemu-devel@nongnu.org; Mon, 21 May 2018 23:48:10 -0400
Date: Tue, 22 May 2018 11:48:05 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180522034805.GD17282@xz-mi>
References: <20180425025459.5258-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180425025459.5258-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/4] qemu-thread: support
 --enable-debug-mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Emilio G . Cota" <cota@braap.org>

On Wed, Apr 25, 2018 at 10:54:55AM +0800, Peter Xu wrote:
> v6:
> - rename __QEMU_THREAD_COMMON_H__ to QEMU_THREAD_COMMON_H
> - collect r-bs for Emilio

Ping.

It's fine if we don't really want this, but in case if this falls
through the cracks...

Regards,

-- 
Peter Xu
