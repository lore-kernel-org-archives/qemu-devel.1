Received: from eggs.gnu.org ([2001:4830:134:3::10]:39345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSGPs-00019I-EM
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 02:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSGPn-0004UH-Ib
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 02:35:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52160 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fSGPn-0004U3-Dz
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 02:34:55 -0400
References: <20180611055352.8097-1-lma@suse.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <331da76e-2ed1-a801-6fe2-3cd2f20261ac@redhat.com>
Date: Mon, 11 Jun 2018 08:34:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180611055352.8097-1-lma@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] net: Fix a potential segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lin Ma <lma@suse.com>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com

On 11.06.2018 07:53, Lin Ma wrote:
> Signed-off-by: Lin Ma <lma@suse.com>
> ---
>  net/net.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Please provide a proper patch description: How can you provoke that
segfault? (i.e. a set of command line options)

 Thomas
