Received: from eggs.gnu.org ([2001:4830:134:3::10]:46493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eREd7-0005Nz-HD
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 04:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eREd6-0006Rd-FM
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 04:56:09 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1513617273-7988-1-git-send-email-thuth@redhat.com>
Date: Tue, 19 Dec 2017 10:55:59 +0100
In-Reply-To: <1513617273-7988-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Mon, 18 Dec 2017 18:14:30 +0100")
Message-ID: <87lghz82j4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/3] block: Deprecated options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> Remove the deprecated "-drive boot" and "-hdachs" options and properly
> mark some other deprecated options in the deprecation chapter.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
