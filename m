Received: from eggs.gnu.org ([2001:4830:134:3::10]:39366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZzWa-0005NG-9u
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:37:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZzWW-0007or-7K
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:37:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZzWW-0007nm-1K
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:37:32 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F333883C2
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 13:37:31 +0000 (UTC)
Date: Fri, 12 Jan 2018 14:37:29 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180112133729.pdqey52xlnuk26la@sirius.home.kraxel.org>
References: <20171122135625.16625-1-fziglio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171122135625.16625-1-fziglio@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] spice: remove QXLWorker interface field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Nov 22, 2017 at 01:56:22PM +0000, Frediano Ziglio wrote:
> This fields points to an old interface that is no more
> used in the current code.

Series queued now.

thanks,
  Gerd
