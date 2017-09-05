Received: from eggs.gnu.org ([2001:4830:134:3::10]:55584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dpD56-0001mk-Cc
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dpD4N-0003Tk-Tl
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:35:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dpD4N-0003RI-O0
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:35:07 -0400
Date: Tue, 5 Sep 2017 13:34:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170905123458.GN17449@stefanha-x1.localdomain>
References: <201709050907288048417@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201709050907288048417@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCHv5 01/03] qemu-iothread: IOThread supports
 theGMainContext event loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wang.yong155@zte.com.cn
Cc: pbonzini@redhat.com, famz@redhat.com, jasowang@redhat.com, zhangchen.fnst@cn.fujitsu.com, zhang.zhanghailiang@huawei.com, wang.guang55@zte.com.cn, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org

On Tue, Sep 05, 2017 at 09:07:28AM +0800, wang.yong155@zte.com.cn wrote:
> A few days without news, ping...

This series should be merged through Jason:

  $ scripts/get_maintainer.pl -f net/colo-compare.c
  Zhang Chen <zhangchen.fnst@cn.fujitsu.com> (supporter:COLO Proxy)
  Li Zhijian <lizhijian@cn.fujitsu.com> (supporter:COLO Proxy)
  Jason Wang <jasowang@redhat.com> (maintainer:Network device ba...)
  qemu-devel@nongnu.org (open list:All patches CC here)
