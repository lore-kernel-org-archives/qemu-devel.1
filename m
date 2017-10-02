Received: from eggs.gnu.org ([2001:4830:134:3::10]:59202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dz0tW-0008AR-JJ
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dz0tS-0005IG-HP
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:36:26 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:43801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dz0tS-0004dL-3H
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:36:22 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1506949228-48987-1-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1506949228-48987-1-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Mon, 02 Oct 2017 15:35:30 +0200
Message-ID: <w51fub13c65.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v0] block: replace throttle config strings
 with macros
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On Mon 02 Oct 2017 03:00:28 PM CEST, Pradeep Jagadeesh wrote:
> This patch set uses the throttle macros to replace throttle 
> config strings.
>
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
