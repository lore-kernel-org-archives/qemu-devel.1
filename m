Received: from eggs.gnu.org ([2001:4830:134:3::10]:45882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dBKFc-0002Sz-E7
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dBKFZ-0004G9-A5
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:09:52 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170511144208.24075-18-pbonzini@redhat.com>
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<20170511144208.24075-18-pbonzini@redhat.com>
Date: Thu, 18 May 2017 14:09:47 +0200
Message-ID: <w51bmqqgyd0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 17/18] block: introduce
 block_account_one_io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

On Thu 11 May 2017 04:42:07 PM CEST, Paolo Bonzini wrote:
> This is the common code to account operations that produced actual I/O.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
