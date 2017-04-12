Received: from eggs.gnu.org ([2001:4830:134:3::10]:52232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cyJma-00033v-IM
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 11:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cyJmU-0003pV-MJ
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 11:02:08 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:59469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1cyJmU-0003YM-8c
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 11:02:02 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1490875813-35588-2-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1490875813-35588-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1490875813-35588-2-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Wed, 12 Apr 2017 17:01:08 +0200
Message-ID: <w514lxtk6vf.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/4] Throttle: Create IOThrottle
 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On Thu 30 Mar 2017 02:10:10 PM CEST, Pradeep Jagadeesh wrote:
> +##
> +# == QAPI IOThrottle definitions
> +##
> +# @IOThrottle:
> +#
> +# A set of parameters describing block
> +#

"describing block ..." ? There's missing text here.

Berto
