Received: from eggs.gnu.org ([2001:4830:134:3::10]:43223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpPOl-00027l-TQ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 22:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpPOl-0003mw-7j
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 22:49:31 -0400
Date: Tue, 14 Aug 2018 10:49:24 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180814024924.GG7549@lemon.usersys.redhat.com>
References: <20180813144320.12382-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813144320.12382-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nvme: simplify plug/unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Mon, 08/13 16:43, Paolo Bonzini wrote:
> bdrv_io_plug/bdrv_io_unplug take care of keeping a nesting count,
> so change s->plugged to just a bool.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Queued, thanks.

Fam
