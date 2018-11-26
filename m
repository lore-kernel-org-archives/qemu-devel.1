Received: from eggs.gnu.org ([2001:4830:134:3::10]:35272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1gR6eY-0005oN-0d
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 21:29:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1gR6eT-0004t7-0D
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 21:29:37 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2734 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1gR6eS-0004lN-L5
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 21:29:32 -0500
From: linzhecheng <linzhecheng@huawei.com>
Date: Mon, 26 Nov 2018 02:29:12 +0000
Message-ID: <D9DE8DBB19F2A24080482022C1DE758302D325DC@DGGEMM529-MBX.china.huawei.com>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel]  [question] live migration about redir-usb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>

Hi, Gerd
I have read this discussion thread about live migration in tcp mode.
https://bugzilla.redhat.com/show_bug.cgi?id=3D1254971
Only spice redirection supports live migration not, but why not tcp mode?
Does usbredirserver not support it or qemu?
