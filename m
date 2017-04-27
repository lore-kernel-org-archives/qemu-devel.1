Received: from eggs.gnu.org ([2001:4830:134:3::10]:51782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3jiM-00031i-NH
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3jiM-0002Og-0K
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:44:10 -0400
Date: Thu, 27 Apr 2017 15:43:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170427134327.GC4805@noname.str.redhat.com>
References: <1493270454-1448-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493270454-1448-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] Issue a deprecation warning if the user
 specifies the "-hdachs" option.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Am 27.04.2017 um 07:20 hat Thomas Huth geschrieben:
> If the user needs to specify the disk geometry, the corresponding
> parameters of the "-device ide-hd" option should be used instead.
> "-hdachs" is considered as deprecated and might be removed soon.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Thanks, applied to block-next.

Kevin
