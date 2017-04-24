Received: from eggs.gnu.org ([2001:4830:134:3::10]:58788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2aec-0004IC-JC
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2aeb-0008QH-Jh
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:51:34 -0400
Date: Mon, 24 Apr 2017 17:51:25 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170424095125.GE14416@lemon.lan>
References: <20170424091659.26708-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170424091659.26708-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/4] Improve convert and dd commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Mon, 04/24 10:16, Daniel P. Berrange wrote:
> Update to
> 
>   v1: https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05699.html
>   v2: https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00728.html
>   v3: https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg04391.html
> 
> This series is in response to Max pointing out that you cannot
> use 'convert' for an encrypted target image.

Looks good to me. Apart from the commit message tweaks:

Reviewed-by: Fam Zheng <famz@redhat.com>
