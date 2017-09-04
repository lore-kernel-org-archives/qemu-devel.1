Received: from eggs.gnu.org ([2001:4830:134:3::10]:50171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1doljk-0006my-Ta
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 03:24:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1doljh-0000Tw-Ki
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 03:24:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1doljh-0000S7-FF
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 03:23:57 -0400
Date: Mon, 4 Sep 2017 15:23:53 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170904072353.GA19748@lemon.lan>
References: <20170903163726.16541-1-n54@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170903163726.16541-1-n54@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] e1000: Rename the SEC symbol to SEQEC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: dmitry@daynix.com, qemu-devel@nongnu.org, jasowang@redhat.com

On Sun, 09/03 18:37, Kamil Rytarowski wrote:
> SunOS defines SEC in <sys/time.h> as 1 (commonly used time symbols).
> 
> This fixes build on SmartOS (Joyent).
> 
> Patch cherry-picked from pkgsrc by jperkin (Joyent).
> 
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>

Cc Jason Wang (net maintainer).

Fam
