Received: from eggs.gnu.org ([2001:4830:134:3::10]:35646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csrTN-0001FA-Cz
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csrTM-00017Q-KL
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:47:45 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:36711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csrTM-00015x-Do
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:47:44 -0400
Received: by mail-wr0-x234.google.com with SMTP id w11so87799094wrc.3
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 06:47:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <076d02e7-643c-5d8b-fcef-8660e1269a05@amsat.org>
References: <20170320173828.3874-1-sauravsachidanand@gmail.com>
	<076d02e7-643c-5d8b-fcef-8660e1269a05@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Mar 2017 14:47:21 +0100
Message-ID: <CAFEAcA9__yPLkfyjqp62F7T0gYMFdKoNZH=hJN9RN9x6+guRDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v5] util: Use
 g_malloc/g_free in envlist.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Saurav Sachidanand <sauravsachidanand@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 28 March 2017 at 14:44, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> Hi Saurav,
>
> you should read the QEMU Coding Style and replace your tabs by 4 spaces.

Er, in review comments on v3 we said not to do that...

thanks
-- PMM
