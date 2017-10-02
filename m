Received: from eggs.gnu.org ([2001:4830:134:3::10]:51571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz0XR-00050L-Sm
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz0XR-00067u-4A
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:13:37 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170916185123.29255-1-mreitz@redhat.com>
	<20170916185123.29255-4-mreitz@redhat.com>
Date: Mon, 02 Oct 2017 15:13:31 +0200
In-Reply-To: <20170916185123.29255-4-mreitz@redhat.com> (Max Reitz's message
	of "Sat, 16 Sep 2017 20:51:20 +0200")
Message-ID: <87poa5k804.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 3/6] qapi: Add qobject_is_equal()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

Max Reitz <mreitz@redhat.com> writes:

> This generic function (along with its implementations for different
> types) determines whether two QObjects are equal.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
