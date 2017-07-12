Received: from eggs.gnu.org ([2001:4830:134:3::10]:58228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVDEo-0007Ex-SK
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVDEl-0005BW-Oc
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:43:14 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:42054 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVDEl-0005BJ-B1
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:43:11 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
	<149942810176.8972.2271168155656858925.stgit@frigg.lan>
	<87d196ai8j.fsf@linaro.org>
Date: Wed, 12 Jul 2017 11:42:57 +0300
In-Reply-To: <87d196ai8j.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
	message of "Tue, 11 Jul 2017 20:25:32 +0100")
Message-ID: <87eftmgi5q.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v12 02/27] cpu-exec: Avoid global variables
 in icount-related functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

Alex Benn=C3=A9e writes:

> Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> writes:

>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>

> I guess. I assume this is also something Emilio is targeting with his
> multi-threaded translation work.

Yes, Emilio suggested to format this patch in a way that won't conflict wit=
h his
changes.

Thanks,
  Lluis
