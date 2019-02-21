Received: from eggs.gnu.org ([209.51.188.92]:33842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gwm9d-0007uP-7I
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:04:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gwm9X-0004bZ-Qu
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:04:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gwm9X-0004ZV-KU
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:04:31 -0500
Date: Thu, 21 Feb 2019 16:34:16 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <d9b63b89-091d-3a7b-fa74-5f91ce6890ff@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1902211633210.4028@xnncv>
References: <20190214201939.494-1-philmd@redhat.com>
	<20190214201939.494-3-philmd@redhat.com>
	<CAMxuvawBXN3CwFhWwyUathUy-+SbURFAy_g8scf54UQx-j+84A@mail.gmail.com>
	<d9b63b89-091d-3a7b-fa74-5f91ce6890ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/9] ccid-card-passthru: Replace never
 trigger if statement by an assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Arash Tohidi Chafi <tohidi.arash@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

+-- On Mon, 18 Feb 2019, Philippe Mathieu-Daud=C3=A9 wrote --+
| On 2/15/19 11:59 AM, Marc-Andr=C3=A9 Lureau wrote:
| Arash or Prasad can you help us here? Do you have a reproducer?

No, we don't have a reproducer handy I'm afraid.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
