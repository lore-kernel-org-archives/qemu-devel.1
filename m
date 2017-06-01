Received: from eggs.gnu.org ([2001:4830:134:3::10]:58189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dGMeF-0004lk-H6
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dGMeC-0007gK-FB
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:44:07 -0400
References: <20170523174420.8903-1-eblake@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <6879a8a1-cb9b-979f-4ea5-96d91820b68a@msgid.tls.msk.ru>
Date: Thu, 1 Jun 2017 12:43:53 +0300
MIME-Version: 1.0
In-Reply-To: <20170523174420.8903-1-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] qapi: Fix some QMP documentation
 regressions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, marcandre.lureau@redhat.com, armbru@redhat.com

23.05.2017 20:44, Eric Blake wrote:
> In the process of getting rid of docs/qmp-commands.txt, we managed
> to regress on some of the text that changed after the point where
> the move was first branched and when the move actually occurred.
> For example, commit 3282eca for blockdev-snapshot re-added the
> extra "options" layer which had been cleaned up in commit 0153d2f.
..
Applied to -trivial, thanks!

/mjt
