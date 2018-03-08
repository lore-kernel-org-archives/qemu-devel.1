Received: from eggs.gnu.org ([2001:4830:134:3::10]:60536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etv6B-000375-AZ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etv6A-0000wZ-Gr
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:56:43 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:45487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etv6A-0000wG-95
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:56:42 -0500
Received: by mail-ot0-x22f.google.com with SMTP id f11so5275401otj.12
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 04:56:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180307112532.24248-1-berrange@redhat.com>
References: <20180307112532.24248-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Mar 2018 12:56:21 +0000
Message-ID: <CAFEAcA_vtSLkn_3EUgpxwSE1XmF45y3fcKJUQU6YN33VUHmUfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/6] Qio next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 7 March 2018 at 11:25, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wro=
te:
> The following changes since commit f2bb2d14c2958f3f5aef456bd2cdb1ff99f4a5=
62:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2018-03-05 16:41:20 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/qio-next-pull-request
>
> for you to fetch changes up to 1939ccdaa61ce6a1f57d83277b3d41d3a9ad3c58:
>
>   qio: non-default context for TLS handshake (2018-03-06 10:19:07 +0000)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Peter Xu (6):
>   qio: rename qio_task_thread_result
>   qio: introduce qio_channel_add_watch_{full|source}
>   qio: store gsources for net listeners
>   qio: non-default context for threaded qtask
>   qio: non-default context for async conn
>   qio: non-default context for TLS handshake
>

Applied, thanks.

-- PMM
