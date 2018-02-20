Received: from eggs.gnu.org ([2001:4830:134:3::10]:48582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eo4Mu-00037j-EI
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:37:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eo4Mr-0007Rq-OS
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:37:48 -0500
Date: Tue, 20 Feb 2018 10:37:35 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180220093735.j5sshv7d357ayp3h@eukaryote>
References: <1519071820-4062-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519071820-4062-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Remove the deprecated -tdf option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Feb 19, 2018 at 09:23:40PM +0100, Thomas Huth wrote:
> It's been marked as deprecated since a very long time already, and
> the parameter is not doing anything useful anymore except for printing
> a warning, so it's now time to finally get rid of this option.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-doc.texi | 7 -------
>  vl.c          | 3 ---
>  2 files changed, 10 deletions(-)

Nice catch.

Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>

[...]

-- 
/kashyap
