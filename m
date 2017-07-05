Received: from eggs.gnu.org ([2001:4830:134:3::10]:50425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSmra-0008I5-Q9
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSmra-0006I8-38
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:09:14 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170622121713.27601-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <86920a79-2910-06d6-7833-54b4881dcc35@redhat.com>
Date: Wed, 5 Jul 2017 18:08:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170622121713.27601-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] docs: add qemu-block-drivers(7) man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org



On 22/06/2017 14:17, Stefan Hajnoczi wrote:
> +@c man begin SYNOPSIS
> +QEMU block driver reference manual
> +@c man end
> +

I think this should be wrapped with @ignore / @end ignore.  Otherwise
looks like a great idea.

Paolo
