Received: from eggs.gnu.org ([2001:4830:134:3::10]:57861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eHYRF-0003UQ-Bp
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 12:03:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eHYRB-0001tB-F2
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 12:03:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:1461)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eHYRB-0001t2-97
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 12:03:49 -0500
References: <1511338200-20417-1-git-send-email-yu.ning@linux.intel.com>
	<18c1591d-a46a-cd22-fd1c-d87780829622@redhat.com>
	<7ce3a417-da98-c5b8-ff6c-ab43d91b63da@linux.intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8bc6cb19-a05f-e592-1e4d-a5af15c0e67f@redhat.com>
Date: Wed, 22 Nov 2017 18:03:40 +0100
MIME-Version: 1.0
In-Reply-To: <7ce3a417-da98-c5b8-ff6c-ab43d91b63da@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Add a blog post about HAXM acceleration on
 Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yu Ning <yu.ning@linux.intel.com>, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, sw@weilnetz.de, Yu Ning <yu.ning@intel.com>

On 22.11.2017 15:52, Yu Ning wrote:
>=20
> On 11/22/2017 20:25, Thomas Huth wrote:
[...]
>> Would it be OK to remove the qemu-debian-wheezy-gui-with-haxm.png from
>> the blog post?
>=20
> Yes, I'm fine with removing it.=C2=A0 Sorry I haven't installed Jekyll =
and
> didn't test the rendering.
>=20
> Would you confirm whether that's the only change I need to make in v2?

No need to respin, since this was just a one-line change, I was able to
do it on my own (I still removed the screenshot, even if it seemed to be
working with Paolo's patch to the CSS, since the screenshot looked just
a bit too big for the blog - I hope that's OK for you).

So the blog post is now online:

 https://www.qemu.org/2017/11/22/haxm-usage-windows/

Thanks again,
 Thomas
