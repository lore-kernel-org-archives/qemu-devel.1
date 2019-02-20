Received: from eggs.gnu.org ([209.51.188.92]:42494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwTkD-00006G-PZ
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:25:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwTkB-0007kM-8E
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:25:09 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwTk7-0006xt-TL
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:25:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so7067426wmh.4
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 07:23:03 -0800 (PST)
References: <20190215094502.32149-1-dgilbert@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190215094502.32149-1-dgilbert@redhat.com>
Date: Wed, 20 Feb 2019 15:18:00 +0000
Message-ID: <87r2c24hg7.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] .travis.yml: Test with
 disable-replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org


Dr. David Alan Gilbert (git) <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> We've had the build break with replication disabled, so lets
> test that case in travis.

Both patches queued to testing/next, thanks.

--
Alex Benn=C3=A9e
