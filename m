Received: from eggs.gnu.org ([2001:4830:134:3::10]:35891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cP5gN-0001cG-RP
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cP5gM-0002Br-UY
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:54:07 -0500
Received: from mail-ua0-x234.google.com ([2607:f8b0:400c:c08::234]:34730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cP5gM-0002Bn-Pq
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:54:06 -0500
Received: by mail-ua0-x234.google.com with SMTP id 34so335197544uac.1
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 02:54:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1483455154-8106-1-git-send-email-kraxel@redhat.com>
References: <1483455154-8106-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jan 2017 10:53:45 +0000
Message-ID: <CAFEAcA_Rq4UBxXeJ2hgGTKRkM1y8pvjh9zOdGdAmHs33VySX9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/5] virtio-gpu: misc bugfixes.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 3 January 2017 at 14:52, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> New year, new pull request.  Here comes the vga patch queue with
> a collection of virtio-gpu fixes.
>
> please pull,
>   Gerd
>
> The following changes since commit 6a928d25b6d8bc3729c3d28326c6db13b9481059:
>
>   Update version for v2.8.0-rc4 release (2016-12-15 07:36:03 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/pull-vga-20170103-1
>
> for you to fetch changes up to 204f01b30975923c64006f8067f0937b91eea68b:
>
>   virtio-gpu: fix memory leak in resource attach backing (2017-01-03 15:47:21 +0100)
>
> ----------------------------------------------------------------
> virtio-gpu: misc bugfixes.
>
Applied, thanks.

-- PMM
