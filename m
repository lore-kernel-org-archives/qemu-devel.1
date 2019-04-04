Received: from eggs.gnu.org ([209.51.188.92]:43727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1hBwt4-00051r-LS
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1hBwt2-0001Ls-NY
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:34:14 -0400
Received: from mail-it1-x134.google.com ([2607:f8b0:4864:20::134]:34170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lepton@google.com>) id 1hBwt0-0001Ht-LU
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:34:10 -0400
Received: by mail-it1-x134.google.com with SMTP id z17so7473702itc.1
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 00:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <201904041010.10367.randrianasulu@gmail.com>
In-Reply-To: <201904041010.10367.randrianasulu@gmail.com>
From: =?UTF-8?B?VGFvIFd1KOWQtOa2m0BFbmcp?= <lepton@google.com>
Date: Thu, 4 Apr 2019 00:33:55 -0700
Message-ID: <CAOvqHj4JsRvm1vzu-VQ0GGGTLEPBT-wyRcRbUHTZGE6m8onjwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Proof of concept for GPU forwarding for Linux
 guest on Linux host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Thu, Apr 4, 2019 at 12:15 AM Andrew Randrianasulu <
randrianasulu@gmail.com> wrote:

> Hi!
>
> I recall I saw something like this some time ago (but in connection with
> qemu-user + ALSA sycallls)
> So far I found this:
>
> https://marc.info/?l=qemu-devel&m=154349285205915
>
> List:       qemu-devel
> Subject:    [Qemu-devel] Support for Intel GPU
> From:       Allan Sandfeld Jensen <kde () carewolf ! com>
> Date:       2018-11-29 11:54:19
>
> Ah, found alsa bits too:
> https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg05334.html

Thanks, I took a look, the previous patches are targeting qemu user mode
while mine is targeting full system virtualization.
There is no plan to merge my code as it is now. I just want to get some
feedbacks first.


>
>
> None of this was merged, as far as I understand.
>
