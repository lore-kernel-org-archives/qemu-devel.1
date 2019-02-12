Received: from eggs.gnu.org ([209.51.188.92]:60209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gtUDl-00079Z-Un
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:19:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gtUDk-0008Hi-6R
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:19:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gtUDe-00081B-Dg
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:19:12 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <154935478086.7509.4349987292919289245.stgit@pasha-VirtualBox>
	<002301d4c207$27d88d50$7789a7f0$@ru>
	<87y36lpjfa.fsf@dusky.pond.sub.org>
	<a44a588734f7101b8a9e1f76c1044e41@ispras.ru>
Date: Tue, 12 Feb 2019 10:18:58 +0100
In-Reply-To: <a44a588734f7101b8a9e1f76c1044e41@ispras.ru> (dovgaluk's message
	of "Tue, 12 Feb 2019 10:18:15 +0300")
Message-ID: <87mun1nz3x.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v12 00/25] Fixing record/replay and adding
 reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dovgaluk <dovgaluk@ispras.ru>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

dovgaluk <dovgaluk@ispras.ru> writes:

> Markus Armbruster =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2019-02-12 10:14:
>> "Pavel Dovgalyuk" <dovgaluk@ispras.ru> writes:
>>
>>> Ping?
>>
>> Are you pinging for more review, or for someone to merge this?
>
> From my point of view this patch set is ready.

MAINTAINERS

    Record/replay
    M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
    R: Paolo Bonzini <pbonzini@redhat.com>

makes me think either Paolo should pick it up, or he should tell you to
post a pull request yourself.
