Received: from eggs.gnu.org ([2001:4830:134:3::10]:41046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSPHm-0001VG-HJ
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSPHS-0007wr-Vr
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:58:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dSPHS-0007wT-Ot
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:58:22 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1498727785.git.maozy.fnst@cn.fujitsu.com>
	<2586a494c1d32ae8beb75c0899a19af9b7fb9398.1498727785.git.maozy.fnst@cn.fujitsu.com>
Date: Tue, 04 Jul 2017 16:58:18 +0200
In-Reply-To: <2586a494c1d32ae8beb75c0899a19af9b7fb9398.1498727785.git.maozy.fnst@cn.fujitsu.com>
	(Mao Zhongyi's message of "Thu, 29 Jun 2017 17:43:01 +0800")
Message-ID: <87r2xwmeph.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 3/4] net/net: Convert parse_host_port()
 to Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, kraxel@redhat.com, pbonzini@redhat.com

Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:

> Cc: berrange@redhat.com
> Cc: kraxel@redhat.com
> Cc: pbonzini@redhat.com
> Cc: jasowang@redhat.com
> Cc: armbru@redhat.com
> Cc: eblake@redhat.com
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
