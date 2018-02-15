Received: from eggs.gnu.org ([2001:4830:134:3::10]:38224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1emKcf-0002k9-25
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:34:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1emKcb-0008Q6-T9
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:34:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:60167)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1emKcb-0008P0-Mh
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:34:49 -0500
From: Andreas Schwab <schwab@suse.de>
References: <mvmmv0nk6g7.fsf@suse.de> <mvmvafah0jd.fsf@suse.de>
	<13e5772f-7b47-4a34-3316-a908dc7d4f85@vivier.eu>
Date: Thu, 15 Feb 2018 15:34:47 +0100
In-Reply-To: <13e5772f-7b47-4a34-3316-a908dc7d4f85@vivier.eu> (Laurent
	Vivier's message of "Thu, 15 Feb 2018 15:31:03 +0100")
Message-ID: <mvmr2pms4mw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Implement copy_file_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

On Feb 15 2018, Laurent Vivier <laurent@vivier.eu> wrote:

> Le 06/02/2018 =C3=A0 11:31, Andreas Schwab a =C3=A9crit=C2=A0:
>> No attempt is made to emulate it on the host.
>
> I don't understand what you mean here...

If your host doesn't have it, neither will the emulation.

Andreas.

--=20
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D=
7
"And now for something completely different."
