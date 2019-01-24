Received: from eggs.gnu.org ([209.51.188.92]:34923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gmc8E-0002dD-C3
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:21:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gmbz7-0007vz-5P
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:11:47 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <271482fe-741a-6a15-15fd-181d4e55a8c4@redhat.com>
References: <271482fe-741a-6a15-15fd-181d4e55a8c4@redhat.com>
Date: Thu, 24 Jan 2019 11:11:06 +0100
Message-ID: <w51bm469xhh.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Consistency of iotests 093 and 136
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Wed 23 Jan 2019 06:00:49 PM CET, Max Reitz wrote:
> Hi,
>
> 093 and 136 seem really flaky to me.  I can reproduce that by running:

That's interesting, I can make 093 fail quite easily now (I haven't
tested the other one yet), but I don't think this happened earlier. I'll
try to figure out what's going on.

Berto
