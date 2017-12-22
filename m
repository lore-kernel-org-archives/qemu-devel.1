Received: from eggs.gnu.org ([2001:4830:134:3::10]:60301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSNtI-0002Jv-0C
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 09:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSNtH-0000pu-9J
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 09:01:36 -0500
Date: Fri, 22 Dec 2017 15:01:22 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171222140122.GJ3763@localhost.localdomain>
References: <1513617273-7988-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513617273-7988-1-git-send-email-thuth@redhat.com>
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

Am 18.12.2017 um 18:14 hat Thomas Huth geschrieben:
> Remove the deprecated "-drive boot" and "-hdachs" options and properly
> mark some other deprecated options in the deprecation chapter.
> 
> Thomas Huth (3):
>   block: Remove the obsolete -drive boot=on|off parameter
>   block: Remove the deprecated -hdachs option
>   block: Mention -drive cyls/heads/secs/trans/serial/addr in deprecation
>     chapter

Thanks, applied to the block branch.

Kevin
