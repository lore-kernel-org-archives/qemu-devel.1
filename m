Received: from eggs.gnu.org ([209.51.188.92]:40776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk59D-0007WY-11
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk55M-00070M-4I
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:39:44 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190117102331.GD27840@stefanha-x1.localdomain>
References: <20190115132942.b7xgq7dpwpkrmebb@perseus.local>
	<20190117102331.GD27840@stefanha-x1.localdomain>
Date: Thu, 17 Jan 2019 11:39:39 +0100
Message-ID: <w51fttr36vo.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] Crash when deleting an iothread that
 is being used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu 17 Jan 2019 11:23:31 AM CET, Stefan Hajnoczi wrote:
> I'm asking because x-blockdev-set-iothread is a low-level testing
> command and it can create IOThread configurations that real-world
> users never reach.

I see, I suppose I had the wrong assumption about that command then!

Berto
