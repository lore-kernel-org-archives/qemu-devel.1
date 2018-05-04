Received: from eggs.gnu.org ([2001:4830:134:3::10]:58249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEdIb-00042v-VJ
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEdIa-0000MK-MD
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:11:09 -0400
Received: from mail-qt0-x22e.google.com ([2607:f8b0:400d:c0d::22e]:33050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEdIa-0000LI-G7
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:11:08 -0400
Received: by mail-qt0-x22e.google.com with SMTP id e8-v6so23132907qth.0
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 09:11:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180213040809.26021-1-f4bug@amsat.org>
	<20180213040809.26021-21-f4bug@amsat.org>
	<CAFEAcA_r2WNVEkE5-p+VuH8f1XnDzHMkUNgNSMrV1ZTkHv4=AQ@mail.gmail.com>
	<20180430134929.edf3vsx4csvsydxi@toto>
	<9a5497c5-555e-c556-f14c-570fb385ae17@amsat.org>
	<CAFEAcA8Oy=z_EfGPgWNyHMOqry=8ziEtbQXfT8qNZtrQExv9rw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <25ecb20c-0535-38e3-38df-32add6902890@amsat.org>
Date: Fri, 4 May 2018 13:11:00 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Oy=z_EfGPgWNyHMOqry=8ziEtbQXfT8qNZtrQExv9rw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="Wjgz2jeXoNnhUVY8KmfJvd8TV4W06Gr2G"
Subject: Re: [Qemu-devel] [PATCH v13 20/30] sdbus: add trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Wjgz2jeXoNnhUVY8KmfJvd8TV4W06Gr2G
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@xilinx.com>, Fam Zheng <famz@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <25ecb20c-0535-38e3-38df-32add6902890@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v13 20/30] sdbus: add trace events
References: <20180213040809.26021-1-f4bug@amsat.org>
 <20180213040809.26021-21-f4bug@amsat.org>
 <CAFEAcA_r2WNVEkE5-p+VuH8f1XnDzHMkUNgNSMrV1ZTkHv4=AQ@mail.gmail.com>
 <20180430134929.edf3vsx4csvsydxi@toto>
 <9a5497c5-555e-c556-f14c-570fb385ae17@amsat.org>
 <CAFEAcA8Oy=z_EfGPgWNyHMOqry=8ziEtbQXfT8qNZtrQExv9rw@mail.gmail.com>
In-Reply-To: <CAFEAcA8Oy=z_EfGPgWNyHMOqry=8ziEtbQXfT8qNZtrQExv9rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Peter, Edgar,

On 05/01/2018 06:03 AM, Peter Maydell wrote:
> On 1 May 2018 at 04:35, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
>> On 04/30/2018 10:49 AM, Edgar E. Iglesias wrote:
>>> On Fri, Apr 27, 2018 at 12:55:21PM +0100, Peter Maydell wrote:
>>>> On 13 February 2018 at 04:07, Philippe Mathieu-Daud=C3=A9 <f4bug@ams=
at.org> wrote:
>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>>> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
>>>>
>>>>> @@ -39,6 +45,7 @@ int sdbus_do_command(SDBus *sdbus, SDRequest *req=
, uint8_t *response)
>>>>>  {
>>>>>      SDState *card =3D get_card(sdbus);
>>>>>
>>>>> +    trace_sdbus_command(sdbus_name(sdbus), req->cmd, req->arg, req=
->crc);
>>>>>      if (card) {
>>>>>          SDCardClass *sc =3D SD_CARD_GET_CLASS(card);
>>>>
>>>> Hi -- as a result of this trace event being added, we now get
>>>> warnings from Coverity that it might use uninitialized data
>>>> (CID1386074, CID1390571, CID1386072, CID1386076). This is because no=
t
>>>> all of our SD
>>>> controllers bother to initialize req->crc, because up til now
>>>> nothing in the SD code looks at it. (I think at least bcm2835_sdhost=
=2Ec
>>>> sdhci.c and ssi-sd.c do this).
>>
>> I was pretty sure we ran Coverity before the stable release :|
>> Maybe they added new 'uninitialized data' checks recently.
>=20
> No, we didn't get a coverity run for a long time (a combination
> of Scan being down and then requiring a new version of the local
> build tools, which we didn't realize because the website didn't
> give a useful error message for that case). So this most recent
> run has brought up a pile of accumulated issues since about
> mid-february.

I sent a fix for those here:
http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg01130.html

I went to the Coverity dashboard to update the Triage information but
the 'apply' box appears grey so I can not update those CIDs.

Regards,

Phil.


--Wjgz2jeXoNnhUVY8KmfJvd8TV4W06Gr2G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlrshhcACgkQ4+MsLN6t
wN7eIA//cF8sKb+BqBhdqhCqOOLbxUgy2lWiYAJf0ND/uGVRvpfzxOlqxWHzyIKQ
dm7weY09KkpOPiUCFFqXwWB//FJUBNkeoZakX7YgAC6WXuZC40SuFetc95FZNekR
zSg44RPyZdTTMlM6sPvfhtv90p+KLdpOCoFATULiYIh5GaYJ+OlmqGf+RceMoENe
C/QdeFUD/FTMWmR4pfUcmaId9YdBBBDW6ueFqYlhv5eB1aObpzO60/hwMjprHUYK
J4dmiD/22rA27s3quGeJeG2CA/RMOkeON2Cx41q73bI7YqSRmEw7UkO9C9TCvPA/
GQNjDdpgLKfw5BhNNVqCm9LoPL999ZsYxupy4igcfaimjwvlPJNwbE6tMSYPHRt1
7taPZ5rcz7WFVYVvZLVnfrejtrsCh4ZjRuYTiP7l1EInGTqEOZoBJLIrI4cmx47L
3hgcMILYs6DgNqaoj+Y39EewAIg9b6h6CYXYrpYB+IYQ1/ap7GGTl+TMO3ep5zJR
vfwMLsCR70Cwdg1hHXJ0a9BbgIcrnhrqryzFVk2pxZJuCLxsX2SEK4w2tjGU6gp7
9g3Cty5+zVp1+asr8ep1JG6sxETxPG6EdLgvOj2WgCpxhSRV7kNemuIPeG0634rA
IVV9MmXYbbE6iiBbCc8JNtzqz+Q+aQ/l9MfX79hVC6m8Fc966No=
=2VDY
-----END PGP SIGNATURE-----

--Wjgz2jeXoNnhUVY8KmfJvd8TV4W06Gr2G--
