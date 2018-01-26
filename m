Received: from eggs.gnu.org ([2001:4830:134:3::10]:41332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eeywn-0007PN-CF
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 03:01:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eeywh-0006NW-Rw
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 03:01:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eeywW-0006L5-5c
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 03:01:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 932AD15F450
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 08:00:58 +0000 (UTC)
References: <20180125190348.8541-1-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7ce6c571-b89a-7ab1-6b5c-d41f4e181464@redhat.com>
Date: Fri, 26 Jan 2018 09:00:56 +0100
MIME-Version: 1.0
In-Reply-To: <20180125190348.8541-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] Link to git web view on
 contribute page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On 25.01.2018 20:03, Eric Blake wrote:
> I was looking for a web view of qemu.git for reference, but
> my first try was at https://www.qemu.org/contribute/ which
> mentions how to clone but with no link for browsing.  Meanwhile,
> the download page pointed people to the list of all repos (and
> even then, only after you switch to the Source code tab), rather
> than the qemu.git repo.  Make the link easier to find.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  _download/source.html | 2 +-
>  contribute.md         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Thanks, applied!

 Thomas
