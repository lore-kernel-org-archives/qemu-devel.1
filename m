Received: from eggs.gnu.org ([2001:4830:134:3::10]:60079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhvLi-0001xc-10
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 06:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhvLg-0005Aq-L7
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 06:14:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dhvLg-0005Ab-EZ
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 06:14:52 -0400
Date: Wed, 16 Aug 2017 18:14:46 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170816101446.GC8396@lemon>
References: <1502874842-4191-1-git-send-email-wang.yong155@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502874842-4191-1-git-send-email-wang.yong155@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCHv3 00/02] Replace the COLO comparing thread
 with IOThread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wang yong <wang.yong155@zte.com.cn>
Cc: zhang.zhanghailiang@huawei.com, zhangchen.fnst@cn.fujitsu.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, wang.guang55@zte.com.cn, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org

On Wed, 08/16 17:14, Wang yong wrote:
> From: Wang Yong <wang.yong155@zte.com.cn>
> 
> Note: This series is based on the patch of "qemu-iothread: 
> IOThread supports theGMainContext event loop".

The syntax for patchew to pick up the dependency automatically:

Based-on: 1502782095-3912-1-git-send-email-wang.yong155@zte.com.cn

Fam
