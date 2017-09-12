Received: from eggs.gnu.org ([2001:4830:134:3::10]:42461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drhFi-00035h-I4
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drhFh-0002ZX-Mk
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:13:06 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:36644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1drhFh-0002Xx-GR
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:13:05 -0400
Received: by mail-wr0-x22d.google.com with SMTP id o42so19428325wrb.3
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 02:13:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAF6HrYym9698mDgQWmKd+q6dVxn1e4DHSm39boaK5mp8CJR0NQ@mail.gmail.com>
References: <CAF6HrYxj5BoTQpQjz95Z1_N_p615jpEE12xh_afuuqE4fcTyLg@mail.gmail.com>
	<CAFEAcA9YNO7kgC8yzZ_RUKck=+98pUET0ogVZ7TvC1kxV+_fFA@mail.gmail.com>
	<CAF6HrYwT7WP_i7cVhvEyRvqSK7J+bLnKU4b+WrMQfVkLaNDrvQ@mail.gmail.com>
	<CAFEAcA9kEEyUj7=7Wd-jNbVOWwfgkj0a201q+L4e5CDR22JUgw@mail.gmail.com>
	<CAF6HrYw9B1ns0ZVtU_gxqJZxOe0dG03UQiAV7FHxBB-wQh6kNQ@mail.gmail.com>
	<CAF6HrYym57hZjSFE=iExPkp8vBX82zqXvTxh8GJDYNPL1FTSqA@mail.gmail.com>
	<CAFEAcA_iKqs_QXz_qSwsOw6A-Z1BJjVN3WPAgaERejWQXrQhNw@mail.gmail.com>
	<CAF6HrYx6_uv-K3JouTb4WTrEEkX25VrhkjAVg8mWG3iarvA=AA@mail.gmail.com>
	<CAF6HrYym9698mDgQWmKd+q6dVxn1e4DHSm39boaK5mp8CJR0NQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 10:12:43 +0100
Message-ID: <CAFEAcA9PMECsYCPm+6iFv1COOcUz4XGGi2p9PPdEgrqhoQAOgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Questions regarding emulated UART in VersatilePB
 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ramy Sameh <ramysameh26@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ahmed Aly <ahmedaly50@gmail.com>

On 12 September 2017 at 08:49, Ramy Sameh <ramysameh26@gmail.com> wrote:
> Hello Peter,
>
> Any suggestions regarding this topic ?

No, I think at this point you're into the stuff that
you need to think about yourself, ie what exactly
you want fault injection to do.

PS: your emails would be easier to read if you followed
the usual convention of putting replies at the bottom
of or interspersed with the quoted text rather than the top.

thanks
-- PMM
