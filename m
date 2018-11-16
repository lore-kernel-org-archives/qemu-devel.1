Received: from eggs.gnu.org ([2001:4830:134:3::10]:40005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gNY6y-0006eb-1z
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:00:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gNY6u-0000Ej-P3
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:00:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gNY6u-0000Dw-Gf
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:00:12 -0500
References: <20181115123218.25387-1-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c53234c7-60ed-20bb-7856-777113b018a6@redhat.com>
Date: Fri, 16 Nov 2018 08:00:06 +0100
MIME-Version: 1.0
In-Reply-To: <20181115123218.25387-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] keymaps: drop support for include files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Li Qiang <liq3ea@gmail.com>

On 2018-11-15 13:32, Gerd Hoffmann wrote:
> Gerd Hoffmann (4):
>   keymaps: remove modifiers include
>   keymaps: drop nl-be map
>   keymaps: remove common include
>   keymaps: drop support for include files

Please give some rationale in the cover letter... why do you want to
drop support for this?

 Thomas
