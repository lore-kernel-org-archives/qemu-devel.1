Received: from eggs.gnu.org ([2001:4830:134:3::10]:38367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fT4Vj-0003hI-85
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fT4Vf-0007f6-B7
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:04:23 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:36564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fT4Ve-0007e3-RK
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:04:19 -0400
Received: by mail-wm0-x230.google.com with SMTP id v131-v6so4911339wma.1
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 05:04:18 -0700 (PDT)
References: <20180612082823.25507-1-berrange@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180612082823.25507-1-berrange@redhat.com>
Date: Wed, 13 Jun 2018 13:04:15 +0100
Message-ID: <874li628qo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] travis: display config.log when configure
 fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> When configure fails in CI systems we must be able to see the contents
> of the config.log file to diagnose the root cause.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

queued thanks.
<snip>

--
Alex Benn=C3=A9e
