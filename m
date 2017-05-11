Received: from eggs.gnu.org ([2001:4830:134:3::10]:37227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hatzimiltos@gmail.com>) id 1d8nu6-0002H8-SE
	for qemu-devel@nongnu.org; Thu, 11 May 2017 09:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hatzimiltos@gmail.com>) id 1d8nu4-0004CB-Rh
	for qemu-devel@nongnu.org; Thu, 11 May 2017 09:13:14 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hatzimiltos@gmail.com>)
	id 1d8nu4-0004Bq-Kc
	for qemu-devel@nongnu.org; Thu, 11 May 2017 09:13:12 -0400
Received: by mail-wr0-x242.google.com with SMTP id v42so3486474wrc.3
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 06:13:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c41daf1b-1ead-0809-57f8-2bfd168b36e6@redhat.com>
References: <CALUZMn0mRMY7mx5ysWdSamV+UGbjwuif8UxQ47gFDK3fx8Hw2w@mail.gmail.com>
	<6e9a0dff-949f-5ac9-2315-cbe0e4c99f58@redhat.com>
	<CALUZMn14qgNz8y+15bsKFwyB9Ganoh0wzu5tfokCDRSASnBeKA@mail.gmail.com>
	<0c725626-6485-c777-46e3-99423670df89@redhat.com>
	<CALUZMn3W06H83E7hr4cHQ2jACp7A2x8hNyU1YirJssd3S7ut2Q@mail.gmail.com>
	<c41daf1b-1ead-0809-57f8-2bfd168b36e6@redhat.com>
From: Miltiadis Hatzimihail <hatzimiltos@gmail.com>
Date: Thu, 11 May 2017 14:12:51 +0100
Message-ID: <CALUZMn3xVkhXRw7M08OaFs_NSE5WVV4U+CqsG2bPqzLLRWORtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Guest SIGILL when different IO is implemented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Ok many thanks for your help.

=E2=80=8BMilton

On Thu, May 11, 2017 at 2:11 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:

>
>
> On 11/05/2017 14:47, Miltiadis Hatzimihail wrote:
> > That's great thanks for the clarification.
> >
> > Is this patch going to make it to the mainline at some point?
>
> Not exactly as is, because it has a small defect (it always reads 16
> bytes from memory), but something like that will.
>
> Paolo
>
