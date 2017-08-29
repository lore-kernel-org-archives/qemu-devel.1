Received: from eggs.gnu.org ([2001:4830:134:3::10]:33200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmhlZ-00032n-Oi
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmhlU-0007YV-TS
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:45:21 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <ac13cdf8-7725-8d5a-9c8b-49ad51eba38e@redhat.com>
References: <20170829120836.16091-1-berto@igalia.com>
	<ac13cdf8-7725-8d5a-9c8b-49ad51eba38e@redhat.com>
Date: Tue, 29 Aug 2017 16:45:14 +0200
Message-ID: <w51d17efn5x.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] misc: Remove unused Error variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-trivial <qemu-trivial@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On Tue 29 Aug 2017 04:40:35 PM CEST, Eric Blake wrote:

>> There's a few cases which we're passing an Error pointer to a

Hmmm... this was "few cases in which", but it seems that I accidentally
removed the "in". Not very important, but whoever commits this feel free
to fix the message.

Berto
